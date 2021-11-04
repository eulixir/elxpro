defmodule Telefonia do
  def cadastrar_assintante(nome, numero, cpf) do
    Assintante.cadastrar(nome, numero, cpf)
  end
end
