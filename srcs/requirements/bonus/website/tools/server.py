import socket

html_content = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Abdelhamid | 1337 Showcase</title>
    <style>
        /* --- RESET & BASIC SETUP --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Courier New', Courier, monospace; /* Terminal Font */
        }

        body {
            background-color: #0d1117; /* GitHub Dark Background */
            color: #c9d1d9;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* --- LAYOUT --- */
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        /* --- HEADER --- */
        header {
            text-align: center;
            padding-bottom: 40px;
            border-bottom: 1px solid #30363d;
            margin-bottom: 40px;
        }

        h1 {
            font-size: 3rem;
            color: #58a6ff; /* Blue Neon */
            margin-bottom: 10px;
        }

        .subtitle {
            font-size: 1.2rem;
            color: #8b949e;
        }

        /* --- SECTIONS --- */
        section {
            margin-bottom: 50px;
        }

        h2 {
            color: #7ee787; /* Green Neon */
            font-size: 1.8rem;
            margin-bottom: 20px;
            border-left: 4px solid #7ee787;
            padding-left: 15px;
        }

        p {
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        /* --- CARDS (For Projects/Skills) --- */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .card {
            background-color: #161b22;
            padding: 20px;
            border: 1px solid #30363d;
            border-radius: 6px;
            transition: transform 0.2s, border-color 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            border-color: #58a6ff;
        }

        .card h3 {
            color: #d2a8ff; /* Purple */
            margin-bottom: 10px;
        }

        /* --- FOOTER --- */
        footer {
            margin-top: auto;
            text-align: center;
            padding: 20px;
            font-size: 0.9rem;
            color: #8b949e;
            border-top: 1px solid #30363d;
        }

        a {
            color: #58a6ff;
            text-decoration: none;
        }
        
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="container">
        <header>
            <h1>Abdelhamid</h1>
            <div class="subtitle">System Architect & Student @ 1337</div>
        </header>

        <section id="about">
            <h2>> whoami</h2>
            <p>
                Hello! I am a software engineering student at <strong>1337 (42 Network)</strong>. 
                I specialize in low-level programming, system administration, and Docker infrastructure.
            </p>
            <p>
                This website is hosted on a custom container I built myself for the Inception project.
            </p>
        </section>

        <section id="skills">
            <h2>> skills</h2>
            <div class="grid">
                <div class="card">
                    <h3>Docker & Ops</h3>
                    <p>Building resilient container infrastructures with Docker Compose, NGINX, and MariaDB.</p>
                </div>
                <div class="card">
                    <h3>C / C++</h3>
                    <p>Deep understanding of memory management, pointers, and object-oriented programming.</p>
                </div>
                <div class="card">
                    <h3>System Admin</h3>
                    <p>Linux administration, bash scripting, and network configuration (TCP/IP).</p>
                </div>
            </div>
        </section>

        <section id="projects">
            <h2>> projects</h2>
            <div class="grid">
                <div class="card">
                    <h3>Inception</h3>
                    <p>System Administration project utilizing Docker to virtualize several services.</p>
                </div>
                <div class="card">
                    <h3>Minishell</h3>
                    <p>Creating a functional shell from scratch in C, parsing commands and managing processes.</p>
                </div>
                <div class="card">
                    <h3>Webserv</h3>
                    <p>Writing an HTTP server in C++98 to understand the web at a socket level.</p>
                </div>
            </div>
        </section>
    </div>

    <footer>
        <p>Built with ❤️ and ☕ at 1337.</p>
        <p>&copy; 2025 Abdelhamid. All rights reserved.</p>
    </footer>

</body>
</html>"""

# AF_INET = IPv4, SOCK_STREAM = TCP
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('0.0.0.0', 1337))
server_socket.listen(5)
print("Python Resume Server running on port 1337...")
while True:
    client_socket, addr = server_socket.accept()
    response = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n" + html_content
    client_socket.send(response.encode('utf-8'))
    client_socket.close()