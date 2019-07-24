const chalk = require("chalk");
const { relative } = require("path");

const projectDirectory = relative(process.cwd(), "outDir");
const pm = "yarn" === "yarn" ? "yarn" : "npm run";

function script(cmd) {
  console.log(chalk`\t{blue $} ${pm} ${cmd}`);
}

function title(msg) {
  console.log(chalk`\n{bold ${msg}}\n`);
}

console.log(chalk`\n{bold Elm project created, batteries included} ⚡️`);

title("Getting Started");

if (true) {
  console.log(chalk`\t{blue $} cd ${projectDirectory}`);
}

script("dev");

title("Testing");

script("test:watch");

if (true) {
  script("cypress:open");
}

title("Production build and deployment");

script("deploy");
script("deploy:prod");

title("Learn more and stay tuned");
console.log(chalk`\t{blue ⇢} https://concat.dev/elm\n`);
