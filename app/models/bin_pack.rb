class BinPack
  def self.pack(bin, rects, rotate)
    items = []

    rects.each do |rect|
      item = if rotate
        BinPacking::Item
      else
        BinPacking::UnrotatableItem
      end

      items << item.new(
        "#{rect[:width]}x#{rect[:height]}",
        rect[:height],
        rect[:width]
      )
    end

    bins = BinPacking::Bin.pack(items, [], BinPacking::Bin.new(
      bin[:height], bin[:width], 0
    ))

    bins.map do |bin|
      modified_bin = {
        width: bin.width,
        height: bin.height,
      }

      modified_bin[:items] = bin.items.map do |item|
        modified_item = {
          name: item[0].obj,
          width: item[0].width,
          height: item[0].height,
          x: item[1],
          y: item[2]
        }

        if item[0].respond_to? :rotated
          modified_item[:rotated] = item[0].rotated
        end

        modified_item
      end

      modified_bin
    end
  end
end
