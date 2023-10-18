## Como Salvar

```sh
$ dconf dump / | sed -n '/\[org.gnome.[^]]*\(keybinding\)\|\(media-key\).*$/,/^$/p' > mappings.conf
$ dconf dump / | sed -n '/\[org.gnome.[^]]*mutter/,/^$/p' > mutter.conf
```

## Como Importar

```sh
$ dconf load / < mappings.conf
$ dconf load / < mutter.conf
```
