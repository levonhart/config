## Como Salvar

```sh
> dconf dump / | sed -n '/\[org.gnome.[^]]*\(keybinding\)\|\(media-key\).*$/,/^$/p' > mappings.conf
```

## Como Importar

```sh
> dconf load / < mappings.conf
```
