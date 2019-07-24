#!/usr/bin/env node
const path = require("path");
const sao = require("sao");
const cac = require("cac");
const chalk = require("chalk");
const { version } = require("./package.json");

const generator = path.resolve(__dirname, "./");

const cli = cac("create-elm-batteries");

cli
  .command("[out-dir]", "Create a project in a custom directory")
  .option("--verbose", "Show debug logs")
  .action((outDir = ".", cliOptions) => {
    console.log();
    console.log(chalk`{cyan create-elm-batteries v${version}}`);
    console.log(chalk`{bold Generating Elm project in ${outDir}}`);

    const { verbose } = cliOptions;
    const logLevel = verbose ? 4 : 2;
    sao({ generator, outDir, logLevel, cliOptions })
      .run()
      .catch(err => {
        console.trace(err);
        process.exit(1);
      });
  });

cli.help();

cli.version(version);

cli.parse();
