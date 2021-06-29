--高速决斗技能-法老的陵墓
Duel.LoadScript("speed_duel_common.lua")
function c100730056.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730056.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730056.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,31076103)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_CARD,1-tp,100730056)
		local tc=g1:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,47355498)
		Duel.SSet(tp,g2)
		local d=Duel.CreateToken(tp,4081094)
		Duel.SendtoDeck(d,tp,1,REASON_RULE)
		local g=Group.CreateGroup()
		local c=Duel.CreateToken(tp,89959682)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,52550973)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		Duel.SendtoGrave(g,REASON_RULE)
	end
	e:Reset()
end