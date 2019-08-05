const { relative } = require("path");

module.exports = {
  prompts: [
    {
      name: "name",
      message: "Project name",
      default: "{outFolder}"
    },
    {
      name: "description",
      message: "Project description",
      default: "My Elm app"
    },
    {
      name: "author",
      type: "string",
      message: "Author name",
      default: "{gitUser.name}",
      store: true
    },
    {
      name: "packageManager",
      message: "Package manager?",
      choices: [{ name: "Yarn", value: "yarn" }, { name: "Npm", value: "npm" }],
      type: "list",
      default: "yarn"
    },
    {
      name: "cypress",
      message: "Testing with Cypress?",
      type: "confirm",
      defaut: true
    },
    {
      name: "netlify",
      message: "Dev platform and deployment with Netlify?",
      type: "confirm",
      defaut: true
    },
    {
      name: "functions",
      message: "Serverless functions?",
      type: "confirm",
      defaut: true
    }
  ],
  templateData() {
    const cypress = this.answers.cypress;
    const netlify = this.answers.netlify;
    const functions = this.answers.functions;
    const packageManager =
      this.answers.packageManager === "yarn" ? "yarn" : "npm run";

    return {
      packageManager,
      cypress,
      netlify,
      functions
    };
  },
  actions() {
    const actions = [
      {
        type: "add",
        files: "**",
        templateDir: "template",
        filters: {
          "cypress/**": "cypress",
          "cypress.json": "cypress",
          "functions/**": "functions"
        }
      }
    ];

    return actions;
  },
  async completed() {
    await this.npmInstall({ npmClient: this.answers.packageManager });

    const chalk = this.chalk;
    const projectDirectory = relative(process.cwd(), this.outDir);
    const runCmd = this.answers.packageManager === "yarn" ? "yarn" : "npm run";

    function script(cmd) {
      console.log(chalk`\t{blue $} ${runCmd} ${cmd}`);
    }

    function title(msg) {
      console.log(chalk`\n{bold ${msg}}\n`);
    }

    console.log(chalk`\n{bold Elm project created, batteries included} ⚡️`);

    title("Getting Started");

    if (this.outDir !== process.cwd()) {
      console.log(chalk`\t{blue $} cd ${projectDirectory}`);
    }

    script("dev");

    title("Learn more and stay tuned");
    console.log(chalk`\t{blue ⇢} https://concat.dev/elm\n`);
  }
};
