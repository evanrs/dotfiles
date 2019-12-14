const _ = require("lodash");
const { mix, rgba } = require("polished");
const darkMode = require("dark-mode");
const createColor = require("color");

let config;

let BROWSERS = [];

const mutateConfig = given =>
  (config = Object.assign(given, createConfig(given)));

const createConfig = ({
  colors,
  backgroundColor = "#06F",
  foregroundColor,
  selectionColor,
  borderColor,
  opacity,
  vibrancy,
  css = "",
}) => {
  backgroundColor = rgba(backgroundColor, opacity);
  // selectionColor = rgba(selectionColor, opacity);
  borderColor = rgba(borderColor, opacity);

  opacity = opacity || 1;
  opacity = vibrancy !== false ? opacity * 0.5 : opacity;

  // if (darkMode.isDark) {
  //   [backgroundColor, foregroundColor] = [foregroundColor, backgroundColor];
  // }

  backgroundColor = rgba(mix(0.5, "#6871ff", backgroundColor), 0.6);

  [backgroundColor, colors] = ensureContrast({ backgroundColor, colors });

  return {
    backgroundColor,
    foregroundColor,
    // selectionColor,
    borderColor,
    opacity,

    vibrancy: vibrancy === false ? "" : "ultra-dark",

    colors: Object.assign(colors, {
      white: rgba(colors.white, 0.9),
      black: rgba(colors.black, 0.9),
    }),

    css: `
      ${css};

      .hyper_main {
        background-color: ${backgroundColor};
      }
    `,
  };
};

const setVibrancy = browser => {
  BROWSERS = [browser, ...BROWSERS].filter(browserWindow => {
    if (browserWindow == null || browserWindow.isDestroyed()) {
      return false;
    }

    browserWindow.setVibrancy(config.vibrancy);

    return true;
  });
};

module.exports.decorateConfig = given => {
  mutateConfig(given);

  setVibrancy();

  return config;
};

module.exports.onWindow = browserWindow => {
  if (config) {
    mutateConfig(config);
  }

  setVibrancy(browserWindow);
};

function ensureContrast({ backgroundColor, colors, contrastRatio = 5 }) {
  let bg = createColor(backgroundColor);

  _.forEach(
    colors,
    (original, i, { [i - 1]: prev = original, [i + 1]: next = original }) => {
      original = createColor(original);
      prev = createColor(prev);
      next = createColor(next);

      let contrast = original.contrast(bg);

      if (contrast < contrastRatio) {
        let altered = increaseContrast(bg, original, contrastRatio, []);
        if (
          prev.contrast(original) < prev.contrast(altered) &&
          next.contrast(original) < next.contrast(altered)
        ) {
          bg = altered;
        }
      }
    },
  );

  const count = {};
  colors = _.mapValues(colors, (color, key) => {
    let fg = createColor(color);
    let next = fg;

    for (let i = 0; i < 50 && next.contrast(bg) < contrastRatio; i++) {
      count[key] = (count[key] || 1) + 1;
      next = increaseContrast(next, bg, contrastRatio);
    }

    return next.rgb().toString();
  });

  return [bg.rgb().toString(), colors];
}

function increaseContrast(original, compared, ratio, ops = []) {
  let prev = original;
  let next = original;
  let contrast = original.contrast(compared);

  for (let [fn, degree] of [
    ...ops,
    ["rotate", -10],
    ["darken", 0.01],
    ["saturate", 0.01],
    ["rotate", -7],
    ["lighten", 0.02],
    ["lighten", 0.005],
    ["rotate", 9],
    ["saturate", 0.01],
    ["rotate", 11],
    ["saturate", 0.02],
    ["rotate", -13],
    ["desaturate", 0.03],
    ["rotate", 15],
  ]) {
    if (next.contrast(compared) > ratio) {
      break;
      return next;
    }

    let test = next[fn](degree);

    if (test.contrast(compared) > prev.contrast(compared)) {
      prev = next;
      next = test;
    }
  }

  return next;
}

//
//
//
//
//
//
//
//
//
//                            The Other
//
//
//
//
//
//
//
//
//
//
//

function ensureContrastPass({ backgroundColor, colors, contrastRatio = 4.5 }) {
  let bg = createColor(backgroundColor);

  const count = {};
  for (
    let iteration = 0, minRatio;
    iteration < 10 && minRatio < contrastRatio;
    i++, minRatio
  ) {
    if (minRatio) {
      bg = bg
        .saturate(iteration * 0.025)
        [bg.luminosity() < fg.luminosity() ? "darken" : "lighten"](
          iteration * 0.01,
        );
    }

    colors = _.mapValues(colors, (color, key) => {
      let fg = createColor(color);

      if (fg.contrast(bg) < contrastRatio) {
        count[key] = (count[key] || 1) + 1;

        fg = fg
          .saturate(iteration * 0.025)
          [bg.luminosity() < fg.luminosity() ? "lighten" : "darken"](
            iteration * 0.01,
          );
      }

      return fg;
    });

    minRatio = _.minBy(_.values(colors), v => bg.contrast(v));
  }

  console.log(count);

  return [bg.rgb().toString(), colors];
}

console.log(createConfig(require("../../hyper").config));
