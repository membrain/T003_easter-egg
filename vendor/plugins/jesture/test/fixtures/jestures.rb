combo :foo, [:left, :right, :left, :right]
combo :bar, [:up, :up, :up]

jesture :fight do
  presses :foo do
    "alert('Fight!')"
  end
end

jesture :color_change do
  presses :bar, "Foo.bar"
  presses :foo do
    "alert('Fight!')"
  end
end
