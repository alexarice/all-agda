dir:

with builtins;

mapAttrs (name: value: import dir (value // { version = name; })) (fromJSON (readFile (dir + "/versions.json")))
