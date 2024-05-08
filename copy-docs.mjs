import path from "path";
import fs from "fs-extra";

const docusaurusBuild = path.join(
  import.meta.dirname,
  "apps",
  "docu-app",
  "build"
);

const nextjsDocsPublic = path.join(
  import.meta.dirname,
  "apps",
  "next-app",
  "public",
  "docs"
);

fs.emptyDirSync(nextjsDocsPublic);
fs.copySync(docusaurusBuild, nextjsDocsPublic);

console.log("Docs copied from Docusaurus to Next.js");
