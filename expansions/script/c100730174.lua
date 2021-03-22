--高速决斗技能-检查我的融合
Duel.LoadScript("speed_duel_common.lua")
function c100730174.initial_effect(c)
	if not c100730174.UsedLP then
		c100730174.UsedLP={}
		c100730174.UsedLP[0]=0
		c100730174.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelMoveCardToFieldCommon(44139064,c)
	aux.SpeedDuelReplaceDraw(c,c100730174.skill,c100730174.con,aux.Stringid(100730174,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730174.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730174,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730174)
		c100730174.UsedLP[tp]=c100730174.UsedLP[tp]+1500
				Duel.Hint(HINT_CARD,1-tp,100730174)
		local c=Duel.CreateToken(tp,23299957)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end

function c100730174.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.DecreasedLP[tp]-c100730174.UsedLP[tp] >= 1500
end