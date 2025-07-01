#!/bin/bash
# Web + App server (Apache + PHP)
DB_SERVER_IP="${db_server_ip}"
DB_NAME="${db_name}"
DB_USERNAME="${db_username}"
DB_PASSWORD="${db_password}"

sudo apt update -y
sudo apt install -y apache2 php libapache2-mod-php php-mysql

# Remove default page
sudo rm -f /var/www/html/index.html

# Create the PHP application
sudo cat > /var/www/html/index.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>My To-Do List</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
        .container { background: #f4f4f4; padding: 30px; border-radius: 10px; }
        h1 { color: #333; text-align: center; }
        .add-form { margin: 20px 0; }
        input[type="text"] { width: 70%; padding: 10px; font-size: 16px; }
        button { padding: 10px 20px; font-size: 16px; background: #007cba; color: white; border: none; cursor: pointer; }
        button:hover { background: #005a87; }
        .todo-item { background: white; margin: 10px 0; padding: 15px; border-radius: 5px; display: flex; justify-content: space-between; }
        .delete-btn { background: #dc3545; padding: 5px 10px; font-size: 12px; }
        .delete-btn:hover { background: #c82333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 My To-Do List (2-Tier)</h1>
        
        <?php
        $servername = "DB_SERVER_IP_PLACEHOLDER";
        $username = "DB_USERNAME_PLACEHOLDER";
        $password = "DB_PASSWORD_PLACEHOLDER";
        $dbname = "DB_NAME_PLACEHOLDER";
        
        try {
            $pdo = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
            $pdo->exec("CREATE TABLE IF NOT EXISTS todos (
                id INT AUTO_INCREMENT PRIMARY KEY,
                task VARCHAR(255) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )");
            
            if ($_POST['action'] == 'add' && !empty($_POST['task'])) {
                $stmt = $pdo->prepare("INSERT INTO todos (task) VALUES (?)");
                $stmt->execute([$_POST['task']]);
            }
            
            if ($_POST['action'] == 'delete' && !empty($_POST['id'])) {
                $stmt = $pdo->prepare("DELETE FROM todos WHERE id = ?");
                $stmt->execute([$_POST['id']]);
            }
            
        } catch(PDOException $e) {
            echo "<p style='color: red;'>Database Error: " . $e->getMessage() . "</p>";
        }
        ?>
        
        <form method="POST" class="add-form">
            <input type="hidden" name="action" value="add">
            <input type="text" name="task" placeholder="Enter a new task..." required>
            <button type="submit">Add Task</button>
        </form>
        
        <div class="todo-list">
            <?php
            try {
                $stmt = $pdo->query("SELECT * FROM todos ORDER BY created_at DESC");
                $todos = $stmt->fetchAll();
                
                if (count($todos) > 0) {
                    foreach ($todos as $todo) {
                        echo "<div class='todo-item'>";
                        echo "<span>" . htmlspecialchars($todo['task']) . "</span>";
                        echo "<form method='POST' style='margin:0;'>";
                        echo "<input type='hidden' name='action' value='delete'>";
                        echo "<input type='hidden' name='id' value='" . $todo['id'] . "'>";
                        echo "<button type='submit' class='delete-btn'>Delete</button>";
                        echo "</form>";
                        echo "</div>";
                    }
                } else {
                    echo "<p style='text-align: center; color: #666;'>No tasks yet. Add one above!</p>";
                }
            } catch(PDOException $e) {
                echo "<p style='color: red;'>Error loading tasks.</p>";
            }
            ?>
        </div>
    </div>
</body>
</html>
EOF

# Replace placeholders
sudo sed -i "s/DB_SERVER_IP_PLACEHOLDER/$DB_SERVER_IP/g" /var/www/html/index.php
sudo sed -i "s/DB_USERNAME_PLACEHOLDER/$DB_USERNAME/g" /var/www/html/index.php
sudo sed -i "s/DB_NAME_PLACEHOLDER/$DB_NAME/g" /var/www/html/index.php
sudo sed -i "s/DB_PASSWORD_PLACEHOLDER/$DB_PASSWORD/g" /var/www/html/index.php

sudo chown -R www-data:www-data /var/www/html/
sudo systemctl start apache2
sudo systemctl enable apache2