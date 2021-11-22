defmodule AssinanteTest do
  use ExUnit.Case

  doctest Assinante

  setup do
    File.write("pre.txt", :erlang.term_to_binary([]))
    File.write("pos.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm!("pre.txt")
      File.rm!("pos.txt")
    end)
  end

  describe "testes responsáveis para cadastro de assinantes" do
    test "deve retornar a estrutura do assinante" do
      assert %Assinante{nome: "test", numero: "teste", cpf: "teste", plano: "plano"}.nome ==
               "test"
    end

    test "criar uma conta prepago" do
      assert Assinante.cadastrar("João Pedro", "123", "123") ==
               {:ok, "Assinante João Pedro foi cadastrado! :)"}
    end

    test "deve retornar erro dizendo que assinante ja esta cadastrado" do
      Assinante.cadastrar("João Pedro", "123", "123")

      assert Assinante.cadastrar("João Pedro", "123", "123") ==
               {:error, "Assinante com este número já cadastrado"}
    end
  end

  describe "testes responsáveis por busca de assinantes" do
    test "busca pospago" do
      Assinante.cadastrar("Jp", "123", "123", :pospago)

      assert Assinante.buscar_assinante("123", :pospago).nome == "Jp"
    end

    test "busca prepago" do
      Assinante.cadastrar("Jp", "123", "123")

      assert Assinante.buscar_assinante("123", :prepago).nome == "Jp"
    end
  end

  describe "delete" do
    test "deve deletar assinante" do
      Assinante.cadastrar("Jp", "123", "123")

      assert Assinante.deletar("123") == {:ok, "Assinante Jp deletado!"}
    end
  end
end
