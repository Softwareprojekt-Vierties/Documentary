# Meeting Protokoll 

Am 09.06.2024 fand ein Meeting von 18:00 Uhr bis 20:00 Uhr statt, an dem Kirill Kuhn, Angelo Mavridis, Marlon Cadell, Luca Eberhardt und Lucas Modesto teilnahmen. Im Fokus des Treffens standen das Bugfixing, die Verbesserung des Backend-Servers sowie der Status-Austausch zwischen Frontend und Backend.

### Was wurde gemacht:

#### Bugfixing:
Ein zentrales Problem, das im Meeting angegangen wurde, betraf die Erstellung von App_User vor Endnutzer, Künstlern und Caterern. Dieser Fehler wurde identifiziert und behoben, um sicherzustellen, dass die App_User ordnungsgemäß vor anderen Benutzerrollen angelegt werden. Diese Korrektur ist entscheidend für die konsistente Verwaltung und Zuordnung der Benutzerrollen innerhalb des Systems.

#### Backend - Server:
Im Backend wurde umfangreicher Code-Refactoring durchgeführt, um die Struktur und Lesbarkeit des Codes zu verbessern. Diese Maßnahme soll langfristig die Wartbarkeit und Erweiterbarkeit des Systems erleichtern.

Ein weiteres wichtiges Update war die Implementierung von Maßnahmen gegen SQL-Injection. Diese Sicherheitsverbesserung ist essentiell, um das System vor potenziellen Angriffen zu schützen und die Integrität der Daten zu gewährleisten.

Eine besondere Herausforderung stellte die Methode zur Eventsuche (searchEvent) dar. Es wurde festgestellt, dass diese Methode nicht optimal parametrisiert ist und daher neu geschrieben werden muss. Die Überarbeitung dieser Methode erfordert einen erheblichen Aufwand, da neue Suchfunktionen hinzugefügt werden sollen. Diese Anpassung ist notwendig, um die Suche effizienter und flexibler zu gestalten und den Benutzern eine bessere Sucherfahrung zu bieten.

#### Frontend und Backend Status-Austausch:
Ein wichtiger Teil des Meetings war der Status-Austausch zwischen dem Frontend- und Backend-Team. Beide Teams gaben Updates zu ihrem aktuellen Fortschritt und koordinierten die nächsten Schritte. Dieser Austausch ist unerlässlich, um sicherzustellen, dass beide Seiten synchron arbeiten und potenzielle Integrationsprobleme frühzeitig identifiziert und gelöst werden können.

### Zusammenfassung:
Das Meeting am 09.06.2024 war geprägt von wichtigen technischen Verbesserungen und der Zusammenarbeit zwischen den Teams. Durch das Bugfixing und die Sicherheitsupdates im Backend sowie die Planung der Überarbeitung der Suchfunktion wurde die Basis für zukünftige Verbesserungen und Erweiterungen des Systems gelegt. Der Status-Austausch zwischen Frontend und Backend war ein wesentlicher Bestandteil des Treffens, um die Koordination und Zusammenarbeit zu stärken und sicherzustellen, dass das Projekt kontinuierlich voranschreitet.