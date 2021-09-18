#!/usr/bin/env zx

// const { Command } = require("commander");
// const program = new Command();
// program.version("0.0.1");

const [scriptName, repo, folderName = repo] = argv._;
const {
  _: [],
  // j: jitter,
  m: minutes,
  h: hours,
  d: days,
} = argv;

const source = { m, h, d };
const options = [];
for (const unit of Object.keys(source)) {
  let value = Number(source[unit] ?? 0);
  if (!Number.isNaN(value) && Number.isFinite(value) && value) {
    options.push(`-v ${value} `);
  }
}

if (options.length > 0) {
  await $`
    export REDATE=$(date ${options.join(" ")});
    export GIT_AUTHOR_DATE=$REDATE;
    export GIT_COMMITTER_DATE=$REDATE
  `;
}
