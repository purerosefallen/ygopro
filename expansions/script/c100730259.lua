--高速决斗技能-引向失败的锁链
Duel.LoadScript("speed_duel_common.lua")
function c100730259.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730259.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730259.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,3,nil,65743242)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,1-tp,100730259)
	Duel.SSet(tp,g1)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)-Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct>0 then
		Duel.DiscardDeck(1-tp,ct,REASON_RULE)
		local g=Group.CreateGroup()
		while ct>0 do
			local c=Duel.CreateToken(tp,67105242)
			g:AddCard(c)
			aux.CardAddedBySkill:AddCard(c)
			Duel.SendtoGrave(g,REASON_RULE)
			ct=ct-1
		end
	end
	e:Reset()
end