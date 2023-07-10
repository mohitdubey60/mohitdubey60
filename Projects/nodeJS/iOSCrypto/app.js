const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
res.statusCode = 200;
res.setHeader('Content-Type', 'text/plain');

aesEncryption();

res.end('Hello World');
});

server.listen(port, hostname, () => {
console.log(`Server running at http://${hostname}:${port}/`);
});


async function aesEncryption() {
    const { createDecipheriv } = await import('node:crypto');
try {
    let sealedBox = Buffer.from("cDyej7xDtnpj1XEAfpa3YXOiVWt4Cv2oIsauFFpN5Pszs7gUz4cHYNj63rab9ZDSgrW3tTryhM5PZnnSrKMHAZz/7sJ69FIjQmP4+FVl7lBq/Nc478JoXDR8E3rhZ67DeITTQwtLYuaMLeZ556BjHH6RCR/AI0Ih/XQFW1PDReA=", 'base64')
let key = Buffer.from("+cqN5tZ8IhjVz8RbZbSDBQ==", 'base64');
let nonce = sealedBox.slice(0, 12);
let ciphertext = sealedBox.slice(12, -16);
let tag = sealedBox.slice(-16);
let decipher = createDecipheriv('aes-128-gcm', key, nonce,);
decipher.setAuthTag(tag);
let decrypted =
    Buffer.concat([decipher.update(ciphertext), decipher.final()])
    .toString('utf8');
    console.log(decrypted);
} catch (err) {
console.error('crypto support is disabled!', err);
}
}