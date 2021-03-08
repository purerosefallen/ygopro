--高速决斗技能-暗之诱惑
Duel.LoadScript("speed_duel_common.lua")
function c100730099.initial_effect(c)
	if not c100730099.UsedLP then
		c100730099.UsedLP={}
		c100730099.UsedLP[0]=0
		c100730099.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730099.skill,c100730099.con,aux.Stringid(100730099,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730099.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730099,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730099)
		c100730099.UsedLP[tp]=c100730099.UsedLP[tp]+1800
				Duel.Hint(HINT_CARD,1-tp,100730099)
		local c=Duel.CreateToken(tp,1475311)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end

function c100730099.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.DecreasedLP[tp]-c100730099.UsedLP[tp] >= 1800
end