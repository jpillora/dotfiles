#!/Users/jpx15/.local/share/nvm/v18.7.0/bin/node --no-warnings
//<xbar.title>Binance Price Ticker</xbar.title>
//<xbar.version>v1.0</xbar.version>
//<xbar.dependencies>node</xbar.dependencies>

try {
  const resp = await fetch(
    "https://api.binance.com/api/v1/ticker/24hr?symbol=BTCAUD"
  );
  const data = await resp.json();
  const f = parseFloat(data.lastPrice);
  if (isNaN(f)) {
    throw `Format`;
  }
  const n = scale(f);
  console.log(`${n} | templateImage=${btcLogo()}`);
} catch (_) {
  console.log("❌");
  process.exit(1);
}

function scale(n, d) {
  // set default number
  if (typeof n !== "number" || isNaN(n)) n = 0;
  if (n === 0) return "0";
  // set default digit count
  if (typeof d !== "number" || isNaN(d)) d = 1;
  // find scale index 1000,100000,... becomes 1,2,...
  var i = Math.floor(Math.floor(Math.log10(n)) / 3);
  var f = Math.pow(10, d);
  var s = Math.round((n / Math.pow(10, i * 3)) * f) / f;
  // concat (no trailing 0s) and choose scale letter
  return (
    s.toString().replace(/\.0+$/, "") +
    " " +
    ["", "K", "M", "G", "T", "P", "Z"][i]
  );
}

//btcLogo
function btcLogo() {
  return "iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAQAAABLCVATAAAACXBIWXMAABYlAAAWJQFJUiTwAAABY\
0lEQVRIx2P4z0AdyEBzg1DAdIYfQJgCZHmCWdsYMAFRBs0BC2UAWT5g1p6hbZAggwIcrgALVQNZSWDWAQY24g3qwRtJ/xg\
eMqxkCGJgotQgGLzAoEUdg/4zvGQQIxzYLAyODF/gQv0MlgwWDK4MOQxbgV5DKG0nLtZ2wIUykII2EMmoU8QZtAWrQQwMB\
+HiDygzaDNc/CQlBskwfIKLN5JrkAxDFsMTuOh9BiFSDXoHDI2HDB9RlJ1kECc2r20hkI5OMXhQxyAQzCTNoDJgaAgAvaL\
LEMkwn+EbkuLvDBLkR78yUoD/Z0gn3yAGhnwk5V2UGBRGLYNmICkvIGzQLqwG8TA0oJQAVvgMymcoYehg+AUXWgoM0kygW\
C/DbpQ4+89wjYERt0FiRNeNX4GlFJ505EykMacZDPGn7HwCBnxiOMcwjcGJcOEvzqADh2vBQk1AVhaYdZCBc7TKpqJBA9Z\
iAwDMH49EXcmY2QAAAABJRU5ErkJggg==";
}
