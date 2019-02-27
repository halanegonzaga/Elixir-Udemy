defmodule Identidade do

  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list()

    %Identidade.Imagem{hex: hex}
  end

  def criar_cor(%Identidade.Imagem{hex: [r, g, b | _]} = imagem) do
    %Identidade.Imagem{imagem | color: {r,g,b}}
  end

  def criar_tabela(%Identidade.Imagem{hex: hex} = imagem) do
    grid = hex
    |> Enum.chunk(3)
    |> Enum.map(&espelhar/1) #passando função dentro de outra
    |> List.flatten
    |> Enum.with_index

    %Identidade.Imagem{imagem | grid: grid}
  end

  def espelhar(linha) do
    [pri, seg | tail] = linha
    linha ++ [seg, pri]
  end
end
