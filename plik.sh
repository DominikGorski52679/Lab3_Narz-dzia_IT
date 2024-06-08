REPOZYTORIA LOKALNE:
git commit - dodaje noewgo commita
git branch myBranch
git branch myBranch; git commit
git switch -> git checkout
git checkout -b nazwa-gałęzi --> ta komenda tworzy nową galąź oraz sie na nią przełącza
git checkout nazwa-gałęzi --> wtedy przełączamy się na tą gałąź
git merge --> Połączenie to tworzy w Git specjalny commit, który ma dwoje różnych rodziców.
git checkout bugFix; git merge main
rebase --> Rebase zasadniczo pobiera zestaw commitów, "kopiuje" je i wrzuca je gdzie indziej. Chociaż brzmi to niejasno, zaletą rebase jest to, że można go użyć do stworzenia ładnej, liniowej sekwencji commitów. Rebase sprawi, że historia commitów w repozytorium będzie wyglądała na dużo prostszą, ponieważ nia ma wtedy commitów scalających.
git rebase nazwa gałęzi
HEAD --> Najpierw musimy porozmawiać o "HEAD". HEAD to symboliczna nazwa dla aktualnie checkoutowanego wyciągniętego commita - jest to zasadniczo commit z najnowszymi zmianami. HEAD zawsze wskazuje na najnowszy commit, który jest odzwierciedlony w drzewie zmian. Większość poleceń git, które wprowadzają zmiany w drzewie, zaczyna się od zmiany HEADa.
git checkout nazwa commita do odłaczenia: git checkout nazwa gdzie chcesz przyłączyć --> aby odłączyć head od commita trzeba wpisać te komendy
git log --> aby zobaczyć hasze, git potrzebuje 4 pierwszych znaków hasza
git checkout main^ --> mamy na myśli pierwszego commita  z gałęzi main, main^^ dziadek
"~" --> TYLDA, Do operatora tyldy możesz dodać numer, który określa, o jaką liczbę rodziców chcesz się cofnąć.
git checkout HEAD~4
git branch -f main HEAD~3 --> przenosi gałąź main trzy commity wstecz - za HEADa
-f --> bezpośrednio przypisać gałąź do commita
git reset -->  odwraca zmiany poprzez przesunięcie referencji gałęzi wstecz w czasie do starszego commita. Można myśleć o tym jako "przepisywaniu historii"; "resetowanie" spowoduje cofnięcie gałęzi, tak jakby commit nigdy nie został dodany.
git reset HEAD~1
git revert NAZWA --> Dzięki git revert możesz wypchnąć swoje zmiany, by podzielić się nimi z innymi.
git cherry-pick --> 
git cherry-pick <Commit1> <Commit2> <...> --> Jest to bardzo prosty sposób określenia, że chcesz przenieść zmiany poniżej swojej obecnej lokalizacji (HEAD).
git rebase -i nazwa~
git commit --amend --> aby dokonać niewielkiej modyfikacji
git tag
git tag va C1 --> czyli C1 został nazwany v1
git describe --> naczniki służą jako świetne "kotwice" w bazie kodu, git ma polecenie opisujące, gdzie jesteś w stosunku do najbliższej "kotwicy", może pomóc ci zorientować się w sytuacji, gdy przesuniesz wiele commitów wstecz lub do przodu w historii.
git describe <ref> --> Gdzie <ref> jest czymkolwiek, co git może odnieść do commita. Jeśli nie podasz <ref>, git użyje aktualnie checkoutowanego miejsca (HEAD).
Wynik tego to:
<tag>_<numCommits>_g<hash> --> tag jest znacznikiem najbliższego przodka w historii, numCommits jest liczbą commitów od tego znacznika, a <hash> jest haszem opisywanego commitu.

ZDALNE REPOZYTORIA:
git clone --> w prawdziwym świecie jest poleceniem, którego będziesz używać do tworzenia lokalnych kopii zdalnych repozytoriów (na przykład z GitHuba). Używamy tego polecenia nieco inaczej w Learn Git Branching -- git clone faktycznie tworzy repozytorium zdalne z lokalnego. Jasne, jest to technicznie odwrotne znaczenie prawdziwego polecenia, ale pomaga zrozumieć zależność między klonowaniem a pracą na zdalnym repozytorium, więc na razie zobaczmy, jak to wygląda w działaniu.
Czym jest o/? Więc jeśli spojrzysz na gałąź o nazwie o/main, nazwą gałęzi (branch name) jest main, a nazwą zdalną (remote name) jest o.
Większość programistów w rzeczywistości nazywa główną (main) zdalną gałąź origin, a nie o. Jest to tak powszechne, że Git w praktyce sam ustawia zdalną nazwę na origin, kiedy wykonujesz git clone na repozytorium.
git checkout o/main; git commit --> git przełączył nas w tryb odłączonego HEADa i nie zaktualizował o/main, kiedy dodaliśmy nowy commit. Dzieje się tak, ponieważ o/main zaktualizuje się tylko przy aktualizacji zdalnego repozytorium.
git fetch --> to polecenie umożliwia nam pobierać dane ze zdalnego repozytorium
git fetch wykonuje dwie rzeczy:
    - pobiera commity, które są w zdalnym repozytorium, ale których brakuje w naszym lokalnym repozytorium i...
    - aktualizuje miejsca, które wskazują nasze zdalne gałęzie (na przykład o/main)
git pull --> jest to polecenie, które W rzeczywistości kolejność działań polegająca na pobieraniu zdalnych zmian (fetch), a następnie łączeniu ich (merge), jest tak powszechna, że sam Git zapewnia polecenie, które robi obie te rzeczy naraz
git fakeTeamwordk foo 3 --> Jednym poleceniem symulujemy, że kolega z zespołu wypycha trzy commity do gałęzi foo na zdalnym repozytorium.
git push --> odpowiada za przesłanie i aktualizację naszych zmian na wybranego remote'a, aby zawierał nowe commity. Gdy git push zostanie ukończony, wszyscy twoi przyjaciele będą mogli pobrać twoją pracę z serwera zdalnego.
    - Uwaga 1 -- zachowanie git push bez argumentów różni się w zależności od jednego z ustawień Git o nazwie push.default. Domyślna wartość tego ustawienia zależy od wersji Git, której używasz. W naszych lekcjach będziemy używać wartości upstream. Nie jest to wielka sprawa, ale warto sprawdzić swoje ustawienia przed użyciem push we własnych projektach.
    - Uwaga 2 -- odpowiednik gałęzi na zdalnym repozytorium będziemy nazywać remote'em. Nazwa ta jest wykorzystywana w Polsce, dlatego będziemy jej używać, aby nie wprowadzać zawiłego nazewnictwa.
git fetch; git rebase o/main; git push
git fetch; git merge o/main; git push
== git pull --rebase; git push == git pull; git push --> jak uaktualnić main i wypchnąć naszą pracę.
A czy mogę to określić samodzielnie?
Jasne, że tak! Możesz kazać dowolnej gałęzi śledzić o/main, i w takim wypadku będzie miała taki sam domyślny cel operacji push i merge co main. To znaczy, że możesz zrobić git push na gałęzi o nazwie totallyNotMain, a twoja praca i tak zostanie wypchnięta do gałęzi main w zdalnym repozytorium!
Są dwa sposoby ustawienia tej właściwości. 
    - Pierwszym jest checkout nowej gałęzi wykorzystujący zdalną gałąź jako określoną referencję. Polecenie git checkout -b totallyNotMain o/main tworzy nową gałąź o nazwie totallyNotMain i każe jej śledzić o/main.
    - drugi, to po prostu użycie opcji git branch -u. Polecenie: git branch -u o/main foo --> spowoduje, że gałąź foo będzie śledzić o/main.
By określić zarówno źródło, jak i cel dla <place>, po prostu połącz je dwukropkiem:
    - git push origin <source>:<destination> --> To nic innego jak refspec z dwukropkiem. Refspec to tylko wymyślny termin oznaczający lokalizację, którą Git potrafi zidentyfikować (na przykład gałąź foo albo po prostu HEAD~1)
git push origin foo^:main --> Git zinterpretował foo^ jako konkretną lokalizację, wrzucił tam wszystkie commity, jakich brakowało jeszcze w zdalnym repo, i na koniec zaktualizował cel.
git fetch origin foo --> Git przejdzie do gałęzi foo w zdalnym repozytorium, weźmie wszystkie commity, których brakuje lokalnie, i zrzuci je nam na lokalną gałąź o/foo.
Git pozwala wykorzystać parametr <source> (źródło) na dwa osobliwe sposoby. Oba są dziwaczne dlatego, że - technicznie rzecz biorąc - możesz określić "nic" jako poprawne źródło zarówno dla git push, jak i git fetch. Tę "nicość" określasz za pomocą pustego argumentu:
    - git push origin :side --> Oto właśnie usunęliśmy skutecznie gałąź side na zdalnym repozytorium, wypychając do niej ideę "nicości".
    - git fetch origin :bugFix --> Natomiast ściągnięcie "nicości" za pomocą fetch do lokalnego miejsca tworzy nową gałąź
Polecenie git pull to naprawdę tylko skrót dla fetch + merge i jedyne, co się liczy dla git pull, to gdzie trafią commity (argument celu, który Git zinterpretuje sobie, wykonując fetch).
