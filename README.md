# Lista Fácil - Mobile App (MVP Core)

Este repositório contém a versão profissional, organizada e compilável do aplicativo de lista de compras rápida e offline-first **Lista Fácil**.

## 🛠️ Tecnologias Principais
* **SDK:** Flutter 3+
* **Arquitetura:** Layered & Feature-First (Apresentação, Domínio e Dados)
* **Gerenciamento de Estado:** Bloc/Cubit (Isola as decisões de UI da lógica de negócio)
* **Banco de Dados Local:** Isar Database (Alta performance e suporte ACID nativo)
* **Injeção de Dependência:** GetIt

---

## 🚀 Como Executar o Projeto Localmente

### Pré-requisitos
* Flutter SDK instalado e configurado no seu PATH.
* Um dispositivo móvel conectado ou simulador pronto.

### Passos para Inicialização

1. **Clonar o Repositório ou Extrair o Código**
   ```bash
   cd lista_facil
   ```

2. **Obter dependências do Flutter**
   ```bash
   flutter pub get
   ```

3. **Gerar arquivos de código gerado (Isar) pelo Build Runner**
   Como o Isar utiliza esquemas de tabelas pré-compilados e eficientes, é necessário rodar o gerador antes de executar:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Executar o Aplicativo**
   ```bash
   flutter run
   ```

📦 Como gerar o Build
Construindo APK (Android)
```bash
flutter build apk --release
```

Construindo App Bundle para o Google Play Store (Android)
```bash
flutter build appbundle --release
```

Construindo IPA (iOS)
```bash
flutter build ipa --release --no-codesign
```

⚙️ Integração Contínua (CI/CD) com Codemagic

Este projeto possui o arquivo codemagic.yaml devidamente configurado na raiz para automatizar o processo de compilação.
Ao conectar o repositório no painel do Codemagic, as builds para Android (APK/AAB) e iOS (IPA) serão geradas automaticamente sempre que houver push na branch main.

Este código foi estruturado de forma que você possa colocá-lo diretamente dentro de um diretório recém-criado em seu ambiente de desenvolvimento local do Flutter, rodar o `build_runner` e iniciar o desenvolvimento imediato sem inconsistências de arquitetura.
