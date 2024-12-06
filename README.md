wikipedia-biotaxonomy
---

- Fetch taxonomy lineage from Wikipedia
- Merge them and produce a cladogram tree (structured data)
- *Draw it (using Wolfram)*

A basic example:

1. Create these files:

   `source.txt`

   format: display-name genus-name
   
   ```text
   †霸王龙 Tyrannosaurus
   †棘龙 Spinosaurus
   ```
   
   `omits.txt`

   format: from,to,replacement
   
   ```text
   Eukaryota,Dracohors,...
   ```

2. Run

   ```shell
   ./wikipedia-fetch
   ./create-tree
   ```
   
3. Draw

   `create-tree` will output some Wolfram code like this:

   ```wolfram
   Tree[Style["...", FontSize -> Larger], {Tree[Style["[总目] 恐龙总目", FontSize -> Larger], {Tree[Style["[目] 蜥臀目", FontSize -> Larger], {Tree[Style["[演化支] 真蜥臀类", FontSize -> Larger], {Tree[Style["[亚目] 兽脚亚目", FontSize -> Larger], {Tree[Style["[演化支] 新兽脚类", FontSize -> Larger], {Tree[Style["[演化支] 鸟吻类", FontSize -> Larger], {Tree[Style["[演化支] 坚尾龙类", FontSize -> Larger], {Tree[Style["[演化支] 俄里翁龙类", FontSize -> Larger], {Tree[Style["[演化支] 鸟兽脚类", FontSize -> Larger], {Tree[Style["[演化支] 虚骨龙类", FontSize -> Larger], {Tree[Style["[演化支] 暴盗龙类", FontSize -> Larger], {Tree[Style["[总科] †暴龙总科", FontSize -> Larger], {Tree[Style["[演化支] †泛暴龙类", FontSize -> Larger], {Tree[Style["[演化支] †真暴龙类", FontSize -> Larger], {Tree[Style["[科] †暴龙科", FontSize -> Larger], {Tree[Style["[亚科] †暴龙亚科", FontSize -> Larger], {Tree[Style["[族] †暴龙族", FontSize -> Larger], {Tree[Style["[属] †暴龙属", FontSize -> Larger], {Tree[Style["†霸王龙", FontSize -> Larger], {}, TreeElementStyle -> {LightOrange}]}]}]}]}]}]}]}]}]}], Tree[Style["[下目] †肉食龙下目", FontSize -> Larger], {Tree[Style["[科] †棘龙科", FontSize -> Larger], {Tree[Style["[亚科] †棘龙亚科", FontSize -> Larger], {Tree[Style["[族] †棘龙族", FontSize -> Larger], {Tree[Style["[属] †棘龙属", FontSize -> Larger], {Tree[Style["†棘龙", FontSize -> Larger], {}, TreeElementStyle -> {LightOrange}]}]}]}]}]}]}]}]}]}]}]}]}]}]}]}]
   ```
   
   Paste it into Wolfram/Mathematica, and you'll get: TODO

For something I've created using these stuff, see TODO