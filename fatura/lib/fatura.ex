defmodule Fatura do

  @moduledoc """
    Este módulo é um teste do curso da Udemy
  """

  @doc """
    Ao receber `fatura` retorna um Array de faturas
      ## Exemplos
      iex> Fatura.criar_faturas(["Telefone", "Agua", "Luz"], [1])
      ["Telefone", "Agua", "Luz"]
  """
  def criar_faturas(faturas, vencimentos) do
    
    # Percorrendo Lista
    for _vencimento <- vencimentos, fatura <- faturas do
      # String template
      # "Fatura: #{fatura} vence no dia: #{vencimento}"
      fatura
    end

    # União das Listas
    # lista_de_faturas =  for()
    # List.flatten(lista_de_faturas)

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

  @doc """
    Verifica se fatura existe
    ## Exemplos
      iex> Fatura.fatura_existe?(["Telefone", "Agua", "Luz"], "Agua")
      true
  """
  def fatura_existe?(faturas, fatura) do
    Enum.member?(faturas,fatura)
  end

  @doc """
    Indicar faturas a pagar

    ##Exemplo
      iex> Fatura.faturas_a_pagar(faturas,1)
      {["Telefone"], ["Agua", "Luz"]}

      iex> {a_pagar, restante} = Fatura.faturas_a_pagar(faturas,1)
      {["Telefone"], ["Agua", "Luz"]}

      iex> a_pagar
      ["Telefone"]

      iex> restante
      ["Agua", "Luz"]
  """
  def  faturas_a_pagar(faturas, quantidade) do
    Enum.split(faturas, quantidade)
  end
end
