## Como Salvar

```sh
dconf dump / | sed -n '/\[org.gnome.[^]]*pop-shell/,/^$/p' > pop-shell.conf
```

## Como Importar

```sh
dconf load / < pop-shell.conf
```

