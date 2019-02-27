defmodule Identidade do

  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
    |> remover_impar
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
          |> :binary.bin_to_list()

    %Identidade.Imagem{hex: hex}
  end

  def criar_cor(%Identidade.Imagem{hex: [r, g, b | _]} = imagem) do
    %Identidade.Imagem{imagem | color: {r, g, b}}
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
    [pri, seg | _tail] = linha
    linha ++ [seg, pri]
  end

  def remover_impar(%Identidade.Imagem{grid: grid} = imagem) do
    new_grid = Enum.filter grid, fn ({valor, _indice}) ->
      rem(valor, 2) == 0
    end

    %Identidade.Imagem{imagem | grid: new_grid}
  end
end
