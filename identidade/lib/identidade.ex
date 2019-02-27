defmodule Identidade do

  def main(input) do
    input
    |> hash_input
    |> criar_cor
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list()

    %Identidade.Imagem{hex: hex}
  end

  def criar_cor(%Identidade.Imagem{hex: [r, g, b | _]} = imagem) do
    %Identidade.Imagem{imagem | color: {r,g,b}}
  end

end
