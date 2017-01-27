module.exports = {
  config: {
    fontSize: 14,
    fontFamily: 'Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',
    cursorShape: 'BLOCK',
    padding: '10px 10px 20px',
    base16: { scheme: 'eighties' },
    env: {},
    bell: false,
    copyOnSelect: false
    // for advanced config flags please refer to https://hyper.is/#cfg
  },
  plugins: [
    'hypersixteen',
    'hypercwd',
    'hyperlinks',
    'hyperterm-blink',
    'hyperterm-cursor',
    'hyperline',
    'hyperterm-dibdabs',
    'hyperfull'
  ],
  localPlugins: []
};
