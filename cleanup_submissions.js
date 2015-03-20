#! /usr/bin/env node
var fs = require('fs');
var path = require('path');
require('shelljs/global');

if (process.argv[2] === '-h' ||
    process.argv[2] === '--help' ||
    process.argv[2] === 'help' ||
    !process.argv[2]) {
  printHelpMessageAndExit();
}

function printHelpMessageAndExit() {
  console.log('Usage: ' + path.basename(process.argv[1]) +
              ' <zip file path> <destination path>');
  process.exit();
}

var src = process.argv[2];
var dest = process.argv[3];
var tmpFolder = './tmp' + Date.now();

mkdir('-p', tmpFolder);

function stripTo(src, dest) {
  var tmpFolder = src + Date.now();
  mv(src, tmpFolder);
  cp('-r', path.join(tmpFolder, '*'), dest);
  rm('-fr', tmpFolder);
}

function parseCorrectFolder(f) {
  var match = /.*attempt_[^_]*_([^().]+).*\.zip$/.exec(f);
  if (match) {
    return match[1].toLowerCase()
      .replace(/-/g, '_')
      .replace(/hw_1/, 'hw1')
      .replace(/hm/, 'hw')
      .replace(/hwk/, 'hw');
  } else return '';
}

function parseUID(folderName) {
  return folderName.split('_')[1];
}

var cmd = 'unzip \'' + path.resolve(src) +
      '\' -d \'' + path.resolve(tmpFolder) + '\'';
exec(cmd, {silent: true});

var errors = [];

var targetFolders = ls(tmpFolder).filter(function(f) {
  return /\.zip$/.test(f);
}).map(function(f) {
  var correctFolderName = parseCorrectFolder(f);

  if (!correctFolderName) {
    errors.push({
      order: -1,
      uid: 'unknown',
      msg: 'can not parse ' + f
    });
    return null;
  }

  return {
    uid: parseUID(correctFolderName),
    correctFolderName: correctFolderName,
    src: path.resolve(tmpFolder, f),
    dest: path.resolve(dest, correctFolderName)
  };

}).filter(function(x) {
  return x !== null;
}).map(function(item) {
  mkdir('-p', dest);
  var cmd = 'unzip \'' + path.resolve(item.src) +
        '\' -d \'' + path.resolve(item.dest) + '\'';
  exec(cmd, {silent: true});
  return item;
}).map(function(item) {
  // If user created a directory
  var rootFolder = ls(item.dest).filter(function(f) {
    return /final/.test(f) && test('-d', path.resolve(item.dest, f));
  })[0];

  if (rootFolder) {
    if (rootFolder !== item.correctFolderName) {
      if (rootFolder.toLowerCase() !== item.correctFolderName) {
        errors.push({
          order: parseInt(item.uid),
          uid: item.uid,
          msg: 'rename ' + rootFolder + ' to ' + item.correctFolderName
        });
      } else {
        errors.push({
          order: parseInt(item.uid),
          uid: item.uid,
          msg: 'good'
        });
      }
    } else {
      errors.push({
        order: parseInt(item.uid),
        uid: item.uid,
        msg: 'good'
      });
    }
    stripTo(path.resolve(item.dest, rootFolder), item.dest);
  } else {
    errors.push({
      order: parseInt(item.uid),
      uid: item.uid,
      msg: item.correctFolderName + ' folder is not created.'
    });
  }
});

errors.sort(function(a, b) {
  return a.order - b.order;
});

var msgs = errors.map(function(err) {
  var score = err.msg === 'good' ? 2 : 0;
  return err.uid + ',' + score + ',"' + err.msg + '"';
});

console.log(msgs.join('\n'));
rm('-fr', tmpFolder);
