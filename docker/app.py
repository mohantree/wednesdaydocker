from http.server import BaseHTTPRequestHandler, HTTPServer


class Application(BaseHTTPRequestHandler):

    def do_GET(self):
        response = """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Docker Private EC2 Application</title>
        </head>
        <body>
            <h1>Docker Application is Running!</h1>
            <h2>Application is running on Private EC2</h2>
            <p>Traffic path:</p>
            <p>Browser → ALB → Private EC2 → Docker</p>
        </body>
        </html>
        """

        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.send_header("Content-Length", str(len(response.encode())))
        self.end_headers()

        self.wfile.write(response.encode())


server = HTTPServer(("0.0.0.0", 8080), Application)

print("Application running on port 8080")

server.serve_forever()