
module BinPacking
  class UnrotatableItem
    attr_reader :width, :height, :obj

    def initialize(obj, width, height)
      @obj, @width, @height = obj, width, height
    end
  end

  class Item < UnrotatableItem
    attr_reader :rotated

    def initialize(obj, width, height, rotated=false)
      super obj, width, height
      @rotated = rotated
    end

    def rotate
      self.class.new(@obj, @height, @width, !@rotated)
    end
  end

  class Bin
    attr_reader :width, :height, :padding, :items

    def initialize(width, height, padding=1)
      @width, @height, @padding = width, height, padding.to_i
      @items = []
      @rows = (0...@height + (@padding * 2)).map{ "_"*(@width + (@padding * 2)) }
    end

    def add(item)
      added = false

      if item.is_a?(Item)
        if item.height > item.width
          added = try_adding(item.rotate)
          return added if added
        end
      end

      if added = try_adding(item)
        return added
      elsif item.is_a?(Item)
        return try_adding(item.rotate)
      end
    end
    alias_method "<<".to_sym, :add
    
    def try_adding(item)
      itemrow = "_" * (item.width.ceil + (@padding * 2))
      @rows.each_with_index {|r,index|
        break if index > @rows.size - (item.height.ceil + @padding * 2)
        next unless r.include?(itemrow)

        idxs = @rows[index + @padding, item.height.ceil + @padding].map { |s| s.index(itemrow) }
        next unless idxs.all?

        idx = idxs.max
        next unless @rows[index, item.height.ceil + (@padding * 2)].all? { |s| s[idx,itemrow.size] == itemrow }

        g = rand(16).to_s(16)
        @rows[index + @padding, item.height.ceil].each{ |s|
          s[idx + @padding, item.width.ceil] = "#{g}" * item.width.ceil
        }
        @items.push([item, idx, index])

        return item
      }
      nil
    end

    def empty?
      @items.empty?
    end

    def to_s
      @rows[@padding..(-1 - @padding)].map{ |r| r[@padding..(-1 - @padding)] }.join("\n")
    end

    def self.pack(items, bins=[], default_bin=nil)
      default_bin ||= self.new(16, 10)
      raise "Expected an array" if !bins.kind_of?(Array)

      items = items.sort_by { |item| item.width*item.height }.reverse
      bins << self.new(default_bin.width, default_bin.height, default_bin.padding) if bins.empty?
      until items.empty?
        fitting = items.find { |item| bins.last.add item }
        if fitting
          items.delete_at(items.index(fitting))
        elsif bins.last.empty?
          raise "Can't fit #{items.inspect} into the bins"
        else
          bins << self.new(default_bin.width, default_bin.height, default_bin.padding) unless items.empty?
        end
      end

      bins
    end
  end
end