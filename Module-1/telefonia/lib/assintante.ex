defmodule Assintante do
  defstruct nome: nil, numero: nil, cpf: nil, plano: nil

  @assinantes %{:pre_pago => "pre_pago.txt", :pos_pago => "pos_pago.txt"}

  def cadastrar(nome, numero, cpf, plano \\ :pre_pago) do
    (read(plano) ++ [%__MODULE__{nome: nome, numero: numero, cpf: cpf, plano: plano}])
    |> :erlang.term_to_binary()
    |> write(plano)
  end

  defp write(lista_assinantes, plano) do
    File.write(@assinantes[plano], lista_assinantes)
  end

  def read(plano) do
    {:ok, assinantes} = File.read(@assinantes[plano])

    assinantes
    |> :erlang.binary_to_term()
  end
end
