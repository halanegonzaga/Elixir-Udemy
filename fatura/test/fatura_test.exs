defmodule FaturaTest do
  use ExUnit.Case
  doctest Fatura

#  test "Criando fatura" do
#    faturas = Fatura.criar_fatura(["Agua", "Luz", "Phone"])
#    assert faturas == ["Agua", "Luz", "Phone"]
#  end
#
#  test "Ordenando Fatura" do
#    faturas = Fatura.criar_fatura(["Agua", "Rua", "Luz"])
#    refute Fatura.orderna_fatura(faturas) == ["Agua", "Rua", "Luz"]
#  end
#
#  test "Existe Fatura" do
#    assert Fatura.fatura_existe?(Fatura.criar_fatura(["Telefone", "Agua", "Luz"]), "Agua") == true
#  end
end
