![banner](https://banners.beyondco.de/The%20Rack.png?theme=light&packageManager=&packageName=https%3A%2F%2Fgithub.com%2Fsherwinchia%2Ftherack&pattern=rain&style=style_1&description=Laravel+7+Ecommerce+Website&md=0&showWatermark=0&fontSize=125px&images=shopping-cart&widths=250&heights=250)

## The Rack - Ecommerce Website

A Laravel 7 e-commerce website for sneakers and apparel, fully containerized with Docker for easy deployment.

---

## Features

### Guest

1. View products catalog
2. Register for an account
3. Add products to cart

### Customer

1. Login/Logout
2. Add products to cart
3. Checkout (No payment gateway implemented, all checkout status=PAID)
4. View purchase history
5. Manage profile

### Admin

1. Login to admin panel
2. CRUD operations for products
3. CRUD operations for product sizes
4. Manage customer orders
5. View user accounts

---

## Quick Start with Docker

### Prerequisites

-   [Docker](https://www.docker.com/get-started) installed on your machine
-   [Docker Compose](https://docs.docker.com/compose/install/) installed

### Installation & Setup

1. **Clone the repository**

    ```bash
    git clone [repository-url]
    cd therack-ECommerce
    ```

2. **Create environment file**

    ```bash
    cp .env.example .env
    ```

3. **Start the application**

    ```bash
    docker compose up -d
    ```

    That's it! The application will:

    - Install all PHP dependencies
    - Set up the MySQL database
    - Run migrations and seed data
    - Create storage symlinks
    - Start all services

4. **Access the application**
    - **Web Application**: http://localhost:8000
    - **PhpMyAdmin**: http://localhost:8080

---

## Database Information

### MySQL Configuration

-   **Host**: `localhost` (or `mysql` from within containers)
-   **Port**: `3306`
-   **Database**: `therack`
-   **Username**: `therack_user`
-   **Password**: `secret`
-   **Root Password**: `root_secret`

### PhpMyAdmin Access

-   **URL**: http://localhost:8080
-   **Server**: `mysql`
-   **Username**: `root` or `therack_user`
-   **Password**: `root_secret` or `secret`

---

## Docker Services

The application runs with the following Docker services:

| Service        | Description                   | Port            |
| -------------- | ----------------------------- | --------------- |
| **app**        | PHP 7.4-FPM application       | 9000 (internal) |
| **nginx**      | Web server                    | 8000            |
| **mysql**      | MySQL 8.0 database            | 3306            |
| **phpmyadmin** | Database management interface | 8080            |
| **node**       | Node.js for asset compilation | -               |

---

## Useful Docker Commands

### Container Management

```bash
# Start all containers
docker compose up -d

# Stop all containers
docker compose down

# View running containers
docker compose ps

# View logs
docker compose logs -f

# View logs for specific service
docker compose logs -f app
docker compose logs -f nginx
```

### Rebuilding Containers

```bash
# Rebuild after code changes
docker compose build

# Rebuild specific service
docker compose build app

# Rebuild without cache
docker compose build --no-cache
```

### Execute Commands Inside Containers

```bash
# Run artisan commands
docker compose exec app php artisan migrate
docker compose exec app php artisan db:seed
docker compose exec app php artisan cache:clear

# Install composer dependencies
docker compose exec app composer install

# Access container shell
docker compose exec app bash

# Run npm commands
docker compose exec node npm install
docker compose exec node npm run dev
```

### Database Commands

```bash
# Access MySQL CLI
docker compose exec mysql mysql -u therack_user -p therack

# Backup database
docker compose exec mysql mysqldump -u root -p therack > backup.sql

# Restore database
docker compose exec -T mysql mysql -u root -p therack < backup.sql
```

---

## Traditional Installation (Without Docker)

If you prefer to run without Docker:

1. Clone the repository
2. Create database in MySQL
3. Configure the `.env` file
4. Run commands:
    ```bash
    composer install
    php artisan key:generate
    php artisan migrate
    php artisan db:seed
    php artisan storage:link
    php artisan serve
    ```

---

## Built With

-   **Laravel 7** - PHP Framework
-   **MySQL 8.0** - Database
-   **Bootstrap** - CSS Framework
-   **jQuery** - JavaScript Framework
-   **Docker** - Containerization
-   **Nginx** - Web Server
-   **PHP 7.4-FPM** - PHP Process Manager

---

## Project Structure

```
therack-ECommerce/
├── app/                    # Application logic
├── database/
│   ├── migrations/        # Database migrations
│   └── seeds/             # Database seeders
├── public/                # Public assets
├── resources/
│   ├── views/             # Blade templates
│   ├── js/                # JavaScript files
│   └── sass/              # SCSS files
├── routes/                # Route definitions
├── storage/               # File storage
│   └── app/public/products/  # Product images
├── docker/                # Docker configuration
│   └── nginx/conf.d/      # Nginx config
├── docker-compose.yml     # Docker services configuration
├── Dockerfile             # Docker image definition
└── .env.example           # Environment variables template
```

---

## Features & Notes

### Storage

-   Product images are stored in `storage/app/public/products/`
-   A symbolic link is automatically created from `public/storage` to `storage/app/public`

### Seeded Data

The application comes with pre-seeded data:

-   18 products (sneakers and apparel)
-   4 users (1 admin, 3 customers)
-   Product stock information

### Payment

-   No payment gateway is implemented
-   All checkouts automatically have status `PAID`
-   This is for demonstration purposes only

### Admin Panel

-   Access at `/admin` route
-   Requires admin role to access

---

## Troubleshooting

### Images not showing

If product images don't display:

```bash
docker compose exec app php artisan storage:link
```

### Permission issues

```bash
docker compose exec app chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
docker compose exec app chmod -R 775 /var/www/storage /var/www/bootstrap/cache
```

### Database connection issues

-   Ensure MySQL container is running: `docker compose ps`
-   Check logs: `docker compose logs mysql`
-   Verify `.env` database credentials match docker-compose.yml

### Port conflicts

If ports 8000, 8080, or 3306 are already in use:

-   Stop other services using these ports, or
-   Modify the port mappings in `docker-compose.yml`

### Fresh start

To completely reset the application:

```bash
docker compose down -v  # Remove containers and volumes
docker compose up -d    # Start fresh
```

---

## Demo

https://www.youtube.com/watch?v=9WpcCnBOa8Q

---

## Contributing

If you find this repository useful, don't forget to star ⭐ the repository!

### Token of appreciation

[Saweria](https://saweria.co/sherwinchia) or
[Paypal](https://www.paypal.me/sherwinchia)

---

## License

MIT

---

## Credits

Built with ❤️ using Laravel Framework
