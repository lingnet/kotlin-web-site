---
type: doc
layout: reference
category: "Compatibility"
title: "Stability of Different Components"
---

# Stability of Different Components

There can be different modes of stability depending of how quickly a component is evolving:
<a name="moving-fast"></a>
*   **Moving fast (MF)**: no compatibility should be expected between even [incremental releases](kotlin-evolution.html#feature-releases-and-incremental-releases), any functionality can be added, removed or changed without warning.

*   **Additions in Incremental Releases (AIR)**: things can be added in an incremental release, removals and changes of behavior should be avoided and announced in a previous incremental release if necessary.

*   **Stable Incremental Releases (SIR)**: incremental releases are fully compatible, only optimizations and bug fixes happen. Any changes can be made in a [feature release](kotlin-evolution.html#feature-releases-and-incremental-releases).

<a name="fully-stable"></a>
*   **Fully Stable (FS)**: incremental releases are fully compatible, feature releases are backwards compatible.

Source and binary compatibility may have different modes for the same component, e.g. the source language can reach full stability before the binary format stabilizes, or vice versa.

The provisions of the Kotlin evolution policy fully apply only to components that have reached Full Stability (FS). From that point on incompatible changes have to be approved by the Language Committee.


<table>
  <tr>
   <td><strong>Component</strong>
   </td>
   <td><strong>Status Entered at version</strong>
   </td>
   <td><strong>Mode for Sources</strong>
   </td>
   <td><strong>Mode for Binaries</strong>
   </td>
  </tr>
  <tr>
   <td>Kotlin/JVM
   </td>
   <td>1.0
   </td>
   <td>FS
   </td>
   <td>FS
   </td>
  </tr>
  <tr>
   <td>kotlin-stdlib (JVM)
   </td>
   <td>1.0
   </td>
   <td>FS
   </td>
   <td>FS
   </td>
  </tr>
  <tr>
   <td>KDoc syntax
   </td>
   <td>1.0
   </td>
   <td>FS
   </td>
   <td>N/A
   </td>
  </tr>
  <tr>
   <td>Coroutines
   </td>
   <td>1.3
   </td>
   <td>FS
   </td>
   <td>FS
   </td>
  </tr>
  <tr>
   <td>kotlin-reflect (JVM)
   </td>
   <td>1.0
   </td>
   <td>SIR*
   </td>
   <td>SIR
   </td>
  </tr>
  <tr>
   <td>Kotlin/JS
   </td>
   <td>1.1
   </td>
   <td>AIR
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Kotlin/Native
   </td>
   <td>1.3
   </td>
   <td>AIR
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Kotlin Scripts (*.kts)
   </td>
   <td>1.2
   </td>
   <td>AIR
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>dokka
   </td>
   <td>0.1
   </td>
   <td>MF
   </td>
   <td>N/A
   </td>
  </tr>
  <tr>
   <td>Kotlin Scripting APIs
   </td>
   <td>1.2
   </td>
   <td>MF
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Compiler Plugin API
   </td>
   <td>1.0
   </td>
   <td>MF
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Serialization
   </td>
   <td>1.3
   </td>
   <td>MF
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Multiplatform Projects
   </td>
   <td>1.2
   </td>
   <td>MF
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Inline classes
   </td>
   <td>1.3
   </td>
   <td>MF
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td>Unsigned arithmetics
   </td>
   <td>1.3
   </td>
   <td>MF
   </td>
   <td>MF
   </td>
  </tr>
  <tr>
   <td><strong>All other experimental features, by default</strong>
   </td>
   <td><strong>N/A</strong>
   </td>
   <td><strong>MF</strong>
   </td>
   <td><strong>MF</strong>
   </td>
  </tr>
</table>
