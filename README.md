# Baking Bad Box
A customizable local development environment.

## Basic setup: Better Call Dev explorer & dashboard
1. Ensure your local node is exposed at `172.17.0.1:8732`
2. Make sure ports `8000` and `42000` are not in use
3. Launch BCD (will be available at https://localhost:8000)
```
make bcd
```
4. Stop BCD
```
make bcd-stop
```
5. Delete all data
```
make bcd-clear
```