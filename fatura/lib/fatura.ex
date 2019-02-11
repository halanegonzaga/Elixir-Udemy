defmodule Fatura do

  @moduledoc """
    Este módulo é um teste do curso da Udemy
  """

  @doc """
    Ao receber `fatura` retorna um Array de faturas
      ## Exemplos
      iex> Fatura.criar_fatura(["Telefone", "Agua", "Luz"])
      ["Telefone", "Agua", "Luz"]
  """
  def criar_fatura(fatura) do
    fatura
  end
  
  @doc """
    Ordenar os itens de faturas
      ## Exemplos
      iex> Fatura.orderna_fatura(["Telefone", "Agua", "Luz"])
      ["Agua", "Luz", "Telefone"]
  """
  def orderna_fatura(faturas) do
    Enum.sort(faturas)
  end

end
