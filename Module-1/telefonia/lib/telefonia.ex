defmodule Telefonia do
  def cadastrar_assintante(nome, numero, cpf) do
    %Assintante{nome: nome, numero: numero, cpf: cpf}
  end
end
