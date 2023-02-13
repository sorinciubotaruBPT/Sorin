# DX Project Template

> For non-DX source based projects, you can go directly to the [Dev Tools](#dev-tools) section.

All new DX projects should be based on this template. All you need to do is to follow the steps bellow.

1. Clone or better fork this repository.
 
   * Fork needs to be created using git remote interface (eg. Bitbucket Cloud) as it is the one who manages the relationship between the original repository and your new fork. Apart from this relationship on remote, it is still just `git clone`.
        * Read more about forks and how to sync your forked repository in order to pull changes (commits) done in this parent repository [on Bitbucket Cloud support here](https://support.atlassian.com/bitbucket-cloud/docs/fork-a-repository).
   * Update settings for your new repository on remote (User and group access, Branch permissions, Branching model etc).

2. Update the following properties for your new project: 

   * *orgName* in `config/project-scratch-def.json` file.   
   * *name* and *description* values in `package.json` file.
   * Note that the standard *Admin* profile is in `.forceignore`. You may need to change this in rare cases e.g. AppExchange app.

3. Optional: update the *sourceApiVersion* in `sfdx-project.json`.

4. Update `README.md` of your new DX project.


## Dev Tools

No matter which metadata format is used on your project, you may find some of the following tools useful. Feel free to reuse their sample configuration which is part of this project.

* [PMD for Apex](https://pmd.github.io/latest/index.html) - static code analysis tool.
    * Sample `pmd-ruleset.xml` is located in project's root folder so, after installation you can run analysis simply by:
        ```sh
        # pmd is alias for 'pmd-bin/bin/run.sh pmd'
        $ pmd --rulesets pmd-ruleset.xml --dir .
        ```
    * IDEs usually offer PMD support and more user-friendly outputs.
    * For additional, project-specific instructions, please use `<description>` element in the file.
    * It is also possible to run analysis for specific files only. Feel free to use the command below and documentation of PMD.
        ```sh
        $ pmd --rulesets pmd-ruleset.xml --file-list pmd-filelist.csv --force-language apex --cache pmd-apex.cache
        ```

* [ESLint](https://eslint.org/docs/user-guide/getting-started) - static code analysis tool for Aura and LWC.
    * ESLint should be installed globally, so it can be shared across projects `$ npm install eslint --save-dev --global`.
    * `.eslintrc.json` holds sample configuration and `package.json` contains preconfigured npm scripts.
        ```sh
        # install project dependencies localy from your project root
        $ npm install

        # run pre-defined scan scripts, see package.json in the root
        $ npm run lint:lwc
        $ npm run lint:aura

        # or both at once
        $ npm run lint
        ```
    * Analysis can be executed for a specific file only, e.g.:
        ```sh
        $ eslint src/main/default/lwc/myLwc/myLwc.js
        ```
    * IDEs usually offer ESLint support and more user-friendly outputs.
    * ESLint configuration can be highly customized, see the official documentation.
    * Feel free to use our company-wide recommended rules via adding [eslint-config-sf-common](https://www.npmjs.com/package/eslint-config-sf-common) package as a dependency in `package.json`.

* [SFDX Data Move Utility](https://help.sfdmu.com) - powerful data migration tool.
    * After installation, see example configuration in `data/export.json`.
    * The idea for DX projects is to keep `data/export.json` configuration present in its repository so that everyone can import sample data into his scratch org easily.
    * Import can be run at any time, nevertheless, it is usually part of scratch org init task.
    * Import data from `data/<sobject>.csv` files using preconfigured npm script:
        ```sh
        $ npm run data:import --target=orgAlias
        ```
    * To export new data, you may need to update the configuration, see plugin's documentation.
    * Export data to csv files using preconfigured npm script:
        ```sh
        $ npm run data:export --source=orgAlias
        ``` 
    * Before committing a new configuration or data, ensure that import works just fine to prevent others having issues.

* [SFDX-Git-Delta](https://github.com/scolladon/sfdx-git-delta) - prepare `package.xml` within seconds.
    * Handy tool for not only deployment-responsible people.
    * Git is a prerequisite. No remote repository is needed though.

* [CI-SFDX-Plugin](https://www.npmjs.com/package/ci-sfdx-plugin) - set of commands making CI and dev's life easier when using scratch orgs.
    * Install the plugin, update configuration in `ciconfig.json` and npm scripts in `package.json` for your new project following steps on the plugin's homepage.
