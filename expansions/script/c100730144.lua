--高速决斗技能-里电子流派
Duel.LoadScript("speed_duel_common.lua")
function c100730144.initial_effect(c)
	if not c100730144.UsedLP then
		c100730144.UsedLP={}
		c100730144.UsedLP[0]=0
		c100730144.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730144.skill,c100730144.con,aux.Stringid(100730144,1))
	aux.SpeedDuelBeforeDraw(c,c100730144.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730144.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730144,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730144)
		c100730144.UsedLP[tp]=c100730144.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x4093)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730144.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_DECK,0,nil,0x4093)>0
		and aux.DecreasedLP[tp]-c100730144.UsedLP[tp] >= 1000
end
function c100730144.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730144)
	local tc=Duel.CreateToken(tp,73026394)
	aux.SpeedDuelSendToHandWithExile(tp,tc)
	e:Reset()
end