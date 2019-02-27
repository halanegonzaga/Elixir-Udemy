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
    Enum.member?(faturas, fatura)
  end

  @doc """
    Indicar faturas a pagar

    ## Exemplos
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


  @doc """
    Salvar em um arquivo as faturas registradas

    ##Exemplo
      iex> fatura = Fatura.criar_faturas(["Telefone", "Agua", "Luz"], [1])
      ["Telefone", "Agua", "Luz"]
      iex> fatura
      ["Telefone", "Agua", "Luz"]
      iex> Fatura.salva_fatura("lib/fatura.txt", fatura)
      :ok

  """

  def salva_fatura(nome_arquivo, faturas) do
    binary = :erlang.term_to_binary(faturas)
    File.write(nome_arquivo, binary)
  end

  @doc """
    Leitura dos arquivos da fatura

    ##Exemplo
      iex> Fatura.load("lib/fatura.txt")
      ["Telefone", "Agua", "Luz"]

      iex> Fatura.load("test")
      "Não foi possivel ler o arquivo"

  """

  def load(nome_arquivo) do
    #    {status, binario} = File.read(nome_arquivo)
    #
    #    # Evitar IFs
    #    case status do
    #      :ok -> :erlang.binary_to_term binario
    #      :error -> "Não foi possivel ler o arquivo"
    #    end

    case File.read(nome_arquivo) do
      {:ok, binario} -> :erlang.binary_to_term binario
      {:error, _erro} -> "Não foi possivel ler o arquivo"
    end

  end

  @doc """
    Exemplo de implementação de pagamento de faturas com operador pipe

    ##Exemplo
      iex> Fatura.pagar_faturas(["Telefone", "Agua"], [5,10], 1)
      {["Agua"], ["Agua", "Telefone", "Telefone"]}

  """

  def pagar_faturas(faturas, vencimentos, quantidade) do

    #Operador pipe

    criar_faturas(faturas, vencimentos)
    |> orderna_fatura
    |> faturas_a_pagar(quantidade)

  end
end
