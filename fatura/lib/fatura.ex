defmodule Fatura do

  @moduledoc """
    Este módulo é um teste do curso da Udemy
  """

  @doc """
    Ao receber `fatura` retorna um Array de faturas
    ## Exemplos
      iex> Fatura.criar_faturas(["agua", "luz"], ["5","10"])
      [
        %Fatura.Conta{fatura: "agua", vencimento: "5"},
        %Fatura.Conta{fatura: "luz", vencimento: "5"},
        %Fatura.Conta{fatura: "agua", vencimento: "10"},
        %Fatura.Conta{fatura: "luz", vencimento: "10"}
      ]
  """
  def criar_faturas(faturas, vencimentos) do

    # Percorrendo Lista
    for vencimento <- vencimentos, fatura <- faturas do
      %Fatura.Conta{vencimento: vencimento, fatura: fatura}  #Utilizando estrutura
    end

  end

  @doc """
    Ordenar os itens de faturas

    ## Exemplos
      iex> fatura = Fatura.criar_faturas(["agua", "luz"], [5])
      iex> Fatura.orderna_fatura(fatura)
      [
        %Fatura.Conta{fatura: "agua", vencimento: 5},
        %Fatura.Conta{fatura: "luz", vencimento: 5}
      ]
  """
  def orderna_fatura(faturas) do
    Enum.sort(faturas)
  end

  @doc """
    Verifica se fatura existe

    ## Exemplos
      iex> fatura = Fatura.criar_faturas(["agua", "luz"], [5])
      iex> Fatura.fatura_existe?(fatura, %Fatura.Conta{fatura: "agua", vencimento: 5})
      true
  """
  def fatura_existe?(faturas, fatura) do
    Enum.member?(faturas, fatura)
  end


  @doc """
    Pagar faturas

    ## Exemplos
      iex> fatura = Fatura.criar_faturas(["agua", "luz"], [5])
      iex> Fatura.faturas_a_pagar(fatura,1)
      {[%Fatura.Conta{fatura: "agua", vencimento: 5}],
      [%Fatura.Conta{fatura: "luz", vencimento: 5}]}

  """
  def  faturas_a_pagar(faturas, quantidade) do
    Enum.split(faturas, quantidade)
  end


  @doc """
    Converter texto em binário e salvar em arquivo

    ## Exemplos
      iex> fatura = Fatura.criar_faturas(["agua", "luz"], [5])
      iex> Fatura.salva_fatura("lib/fatura.txt", fatura)
      :ok
  """

  def salva_fatura(nome_arquivo, faturas) do
    binary = :erlang.term_to_binary(faturas)
    File.write(nome_arquivo, binary)
  end

  @doc """
    Fazer leitura de arquivo

    ## Exemplos
      iex> fatura = Fatura.criar_faturas(["agua", "luz"], [5])
      iex> Fatura.load("lib/fatura.txt")
  """

  def load(nome_arquivo) do
    case File.read(nome_arquivo) do
      {:ok, binario} -> :erlang.binary_to_term binario
      {:error, _erro} -> "Não foi possivel ler o arquivo"
    end

  end

  @doc """
    Função para utilizar exemplo do operador Pipe

  """

  def pagar_faturas(faturas, vencimentos, quantidade) do

    criar_faturas(faturas, vencimentos)
    |> orderna_fatura
    |> faturas_a_pagar(quantidade)

  end
end
