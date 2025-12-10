local characters = { 
  'ᚠ','ᚢ','ᚣ','ᚤ','ᚥ','ᚦ','ᚧ','ᚨ','ᚩ','ᚪ','ᚫ',
  'ᚬ','ᚭ','ᚮ','ᚯ','ᚰ','ᚱ','ᚲ','ᚳ','ᚴ','ᚶ','ᚷ',
  'ᚸ','ᚹ','ᚺ','ᚻ','ᚼ','ᚽ','ᚾ','ᚿ','ᛀ','ᛁ','ᛂ',
  'ᛃ','ᛄ','ᛅ','ᛆ','ᛇ','ᛈ','ᛉ','ᛊ','ᛋ','ᛌ','ᛍ',
  'ᛎ','ᛏ','ᛐ','ᛑ','ᛒ','ᛓ','ᛔ','ᛕ','ᛖ','ᛗ','ᛘ',
  'ᛙ','ᛚ','ᛛ','ᛜ','ᛝ','ᛞ','ᛟ','ᛠ','ᛡ','ᛢ','ᛣ',
  'ᛤ','ᛥ','ᛦ','ᛧ','ᛨ','ᛩ','ᛪ','᛫','᛬','᛭','ᛮ',
  'ᛯ','ᛰ',
}

local function get_prefix(diagnostic, i, total)
  local char = characters[math.random(#characters)]
  return char .. " "
end

local frametime = 100

local prefix_animation_timer = vim.loop.new_timer()

prefix_animation_timer:start(0, frametime, vim.schedule_wrap(function()
  vim.diagnostic.config {
    virtual_text = {
      prefix = get_prefix,
    },
    severity_sort = true,
  }
end))
