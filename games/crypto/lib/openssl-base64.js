var END_OF_INPUT = -1;
var base64Chars = new Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/");
var reverseBase64Chars = new Array();
for (var i = 0; i < base64Chars.length; i++) {
	reverseBase64Chars[base64Chars[i]] = i
}
var base64Str;
var base64Count;
function setBase64Str(a) {
	base64Str = a;
	base64Count = 0
}
function readBase64() {
	if (!base64Str) {
		return END_OF_INPUT
	}
	if (base64Count >= base64Str.length) {
		return END_OF_INPUT
	}
	var a = base64Str.charCodeAt(base64Count) & 255;
	base64Count++;
	return a
}
function openssl_base64_encode(f) {
	var d = utf8_encode(f);
	setBase64Str(d);
	var a = "";
	var e = new Array(3);
	var c = 0;
	var b = false;
	while (!b && (e[0] = readBase64()) != END_OF_INPUT) {
		e[1] = readBase64();
		e[2] = readBase64();
		a += (base64Chars[e[0] >> 2]);
		if (e[1] != END_OF_INPUT) {
			a += (base64Chars[((e[0] << 4) & 48) | (e[1] >> 4)]);
			if (e[2] != END_OF_INPUT) {
				a += (base64Chars[((e[1] << 2) & 60) | (e[2] >> 6)]);
				a += (base64Chars[e[2] & 63])
			} else {
				a += (base64Chars[((e[1] << 2) & 60)]);
				a += ("=");
				b = true
			}
		} else {
			a += (base64Chars[((e[0] << 4) & 48)]);
			a += ("=");
			a += ("=");
			b = true
		}
		c += 4;
		if (c >= 76) {
			a += ("\n");
			c = 0
		}
	}
	return a.trim()
}
function readReverseBase64() {
	if (!base64Str) {
		return END_OF_INPUT
	}
	while (true) {
		if (base64Count >= base64Str.length) {
			return END_OF_INPUT
		}
		var a = base64Str.charAt(base64Count);
		base64Count++;
		if (reverseBase64Chars[a]) {
			return reverseBase64Chars[a]
		}
		if (a == "A") {
			return 0
		}
	}
	return END_OF_INPUT
}
function ntos(a) {
	a = a.toString(16);
	if (a.length == 1) {
		a = "0" + a
	}
	a = "%" + a;
	return unescape(a)
}
function openssl_base64_decode(d) {
	setBase64Str(d);
	var a = "";
	var c = new Array(4);
	var b = false;
	while (!b && (c[0] = readReverseBase64()) != END_OF_INPUT && (c[1] = readReverseBase64()) != END_OF_INPUT) {
		c[2] = readReverseBase64();
		c[3] = readReverseBase64();
		a += ntos((((c[0] << 2) & 255) | c[1] >> 4));
		if (c[2] != END_OF_INPUT) {
			a += ntos((((c[1] << 4) & 255) | c[2] >> 2));
			if (c[3] != END_OF_INPUT) {
				a += ntos((((c[2] << 6) & 255) | c[3]))
			} else {
				b = true
			}
		} else {
			b = true
		}
	}
	return utf8_decode(a.trim())
};
