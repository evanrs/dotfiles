#!/usr/bin/env zx

/**
 * The Listicle of Features
 * •••Look at how create-next-app is written and clone
 * •••Extend with smart config for git repository + husky
 * •••Update package name to match folder name
 * •••Provide explicit option for (--path | --name)
 * •••Extend with questions for `patterbuffer energize`
 *
 *
 *
 *
 */

// const { Command } = require("commander");
// const program = new Command();
// program.version("0.0.1");

const [scriptName, repo, folderName = repo] = argv._;

console.table({ repo, folderName });

await $`yarn create next-app ${folderName} --example https://github.com/evanrs/${repo} --example-path src`;

const mkdir = (path) => $`mkdir -p ${path}`;
