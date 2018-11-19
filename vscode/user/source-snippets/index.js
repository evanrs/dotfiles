const globby = require("globby");
const extra = require("fs-extra");

(async () => {
  const paths = await globby("./snippets/*");

  Promise.all(
    paths.map(async path => {
      console.log(path);
      const buffer = await extra.readFile(path);
      console.log(path, buffer);
    }),
  );
})();
