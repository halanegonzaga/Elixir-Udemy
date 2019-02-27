defmodule Identidade do

  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
    |> remover_impar
    |> constroi_pixel
    |> desenhar
    |> salvar(input)
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

  def constroi_pixel(%Identidade.Imagem{grid: grid} = imagem) do
    pixel_map = Enum.map grid, fn {_valor, indice} ->
      h = rem(indice, 5) * 50
      v = div(indice, 5) * 50
      t_esquerda = {h, v}
      t_direita = {h + 50, v + 50}

      {t_esquerda, t_direita}
    end

    %Identidade.Imagem{imagem | pixel_map: pixel_map}
  end

  def desenhar(%Identidade.Imagem{color: cor, pixel_map: pixel_map}) do
    imagem = :egd.create(250, 250)
    cor = :egd.color(cor)

    Enum.each pixel_map, fn {start, stop} ->
      :egd.filledRectangle(imagem, start, stop, cor)
    end

    :egd.render(imagem)
  end

  def salvar(imagem, input) do
    File.write("#{input}.png", imagem)
  end
end
