dir:

with builtins;

mapAttrs (name: value: value // { version = name; inherit dir; }) (fromJSON (readFile (dir + "/versions.json")))
