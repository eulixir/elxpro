defmodule Telefonia do
  def start() do
    File.write("pre_pago.txt", :erlang.term_to_binary([]))
    File.write("pos_pago.txt", :erlang.term_to_binary([]))
  end

  def cadastrar_assintante(nome, numero, cpf, plano) do
    Assintante.cadastrar(nome, numero, cpf, plano)
  end
end
