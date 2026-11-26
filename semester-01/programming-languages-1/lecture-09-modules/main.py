import argparse
import json
from contextlib import contextmanager
from http.server import BaseHTTPRequestHandler, HTTPServer
from threading import Thread

import requests
from calculator import add, subtract, multiply, divide


class DemoHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/api/status":
            self.send_error(404)
            return
        data = json.dumps({"status": "ok", "course": "Python"}).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def log_message(self, format, *args):
        pass


@contextmanager
def local_api():
    server = HTTPServer(("127.0.0.1", 0), DemoHandler)
    worker = Thread(target=server.serve_forever, daemon=True)
    worker.start()
    try:
        yield f"http://127.0.0.1:{server.server_port}/api/status"
    finally:
        server.shutdown()
        server.server_close()
        worker.join()


def request_data(url):
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    return response.json()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", help="Адрес доступного JSON API")
    args = parser.parse_args()
    print("Калькулятор:", add(8, 2), subtract(8, 2), multiply(8, 2), divide(8, 2))
    if args.url:
        print(request_data(args.url))
    else:
        with local_api() as url:
            print(request_data(url))


if __name__ == "__main__":
    main()
