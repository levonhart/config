## Como Salvar

```sh
$ dconf dump / | sed -n '/\[org.gnome.[^]]*\(keybinding\)\|\(media-key\).*$/,/^$/p' > mappings.conf
$ dconf dump / | sed -n '/\[org.gnome.[^]]*pop-shell/,/^$/p' > pop-shell.conf
```

## Como Importar

```sh
$ dconf load / < mappings.conf
$ dconf load / < pop-shell.conf
```
