defmodule Assintante do
  defstruct nome: nil, numero: nil, cpf: nil, plano: nil

  @assinantes %{:pre_pago => "pre_pago.txt", :pos_pago => "pos_pago.txt"}

  def buscar_assinante(numero, key \\ :all) do
    buscar(numero, key)
  end

  defp buscar(numero, :pre_pago) do
    assinantes_pre_pago()
    |> Enum.find(assinantes(), &(&1.numero == numero))
  end

  defp buscar(numero, :pos_pago) do
    assinantes_pos_pago()
    |> Enum.find(assinantes(), &(&1.numero == numero))
  end

  defp buscar(numero, :all) do
    assinantes()
    |> Enum.find(assinantes(), &(&1.numero == numero))
  end

  def assinantes_pre_pago(), do: read(:pre_pago)
  def assinantes_pos_pago(), do: read(:pos_pago)
  def assinantes(), do: read(:pre_pago) ++ read(:pos_pago)

  def cadastrar(nome, numero, cpf, plano \\ :pre_pago) do
    case buscar_assinante(numero) do
      nil ->
        (read(plano) ++ [%__MODULE__{nome: nome, numero: numero, cpf: cpf, plano: plano}])
        |> :erlang.term_to_binary()
        |> write(plano)

        {:ok, "Assinante #{nome} foi cadastrado! :)"}

      _assinante ->
        {:error, "Assinante com este número já cadastrado"}
    end
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
